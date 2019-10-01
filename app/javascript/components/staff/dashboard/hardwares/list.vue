<template lang="pug">
  q-spinner-bars(v-if="is_loading")
  div(v-else)
    q-table.hardwares.shadow.bg-gray-100.my-2.rounded(
        title=""
        :data="hardwares"
        :columns="columns"
        row-key="id"
        no-data-label="Empty list of hardware."
      )
      template(v-slot:body-cell-action="props")
        q-td(:props="props")
          q-btn(icon="fas fa-trash" @click="deleteHardware(props.row)" method="delete")
</template>

<script>
export default {
  data() {
    return {
      is_loading: true,
      hardwares: this.getHardwaresList(),
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
      ],
    };
  },
  methods: {
    getHardwaresList() {
      this.$api.hardwares
        .index()
        .then(
          (response) => {
            this.hardwares = response.data.data.map(i => i.attributes);
          }).finally(() => (this.is_loading = false));
    },
    deleteOrganization(organization) {
      this.$api.hardwares
        .destroy(hardware.id)
        .then(
          response => {
            this.getHardwaresList();
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
    this.$eventBus.$on('createHardware', () => {
      this.getHardwaresList();
    });
  },
}
</script>

<style scoped>
</style>
