<template lang="pug">
  q-spinner-bars(v-if="is_loading")
  div(v-else)
    q-table.devices.shadow.bg-gray-100.my-2.rounded(
        title=""
        :data="devices"
        :columns="columns"
        row-key="id"
        no-data-label="Empty list of device."
      )
      template(v-slot:body-cell-action="props")
        q-td(:props="props")
          q-btn-group
            q-btn(icon="fas fa-edit" @click="doEditDialog(props.row)")
            q-btn(icon="fas fa-trash" @click="deleteDevice(props.row)" method="delete")
    router-view(name="editForm")
</template>

<script>
export default {
  data() {
    return {
      is_loading: true,
      devices: this.getDevicesList(),
      columns: [
        {
          name: 'name',
          required: true,
          label: 'Name',
          align: 'left',
          field: 'name',
          sortable: true,
        },
        {
          name: 'kind',
          align: 'left',
          label: 'Type',
          field: 'kind',
          sortable: true,
        },
        {
          name: 'number',
          align: 'left',
          label: 'Number',
          field: 'number',
        },
        { name: 'action', label: 'actions', align: 'left' }
      ],
    };
  },
  methods: {
    getDevicesList() {
      this.$api.devices
        .index()
        .then(
          (response) => {
            this.devices = response.data.data.map(i => i.attributes);
          }).finally(() => (this.is_loading = false));
    },
    doEditDialog(row) {
      this.$router.push({ path: `${this.$route.path}/${row.id}/edit` })
    },
    deleteDevice(device) {
      this.$api.devices
        .destroy(device.id)
        .then(
          response => {
            this.getDevicesList();
            this.$q.notify({
              icon: 'fas fa-trash',
              color: 'positive',
              message: 'Successfully deleted'
            })
          },
          errors => {
            this.$q.notify({
							color: 'negative',
							message: errors.response.data
						});
          })
    },
  },
  mounted() {
    this.$eventBus.$on('needUpdateDeviceList', () => {
      this.getDevicesList();
    });
  },
}
</script>

<style scoped>
</style>
