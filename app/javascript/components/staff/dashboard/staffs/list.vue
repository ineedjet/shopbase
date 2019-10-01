<template lang="pug">
  q-spinner-bars(v-if="is_loading")
  div(v-else)
    q-table.staffs.shadow.bg-gray-100.my-2.rounded(
        title=""
        :data="staffs"
        :columns="columns"
        row-key="id"
        no-data-label="Empty list of staff."
      )
      template(v-slot:body-cell-action="props")
        q-td(:props="props")
          q-btn(icon="fas fa-trash" @click="deleteStaffs(props.row)" method="delete")
</template>

<script>
export default {
  data() {
    return {
      is_loading: true,
      staffs: this.getStaffsList(),
      columns: [
        {
          name: 'id',
          required: true,
          label: 'ID',
          field: 'id',
          sortable: true,
        },
        {
          name: 'email',
          required: true,
          label: 'Email',
          align: 'left',
          field: 'email',
          sortable: true,
        },
        {
          name: 'name',
          required: true,
          label: 'Name',
          align: 'left',
          field: 'fullname',
          sortable: true,
        },
        {
          name: 'position',
          align: 'left',
          label: 'Position',
          field: 'position',
          sortable: true,
        },
      ],
    };
  },
  methods: {
    getStaffsList() {
      this.$api.staffs
        .index()
        .then(
          (response) => {
            this.staffs = response.data.data.map(i => i.attributes);
          }).finally(() => (this.is_loading = false));
    },
    deleteStaff(staff) {
      this.$api.staffs
        .destroy(staff.id)
        .then(
          response => {
            this.getStaffsList();
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
    this.$eventBus.$on('createStaff', () => {
      this.getStaffsList();
    });
  },
}
</script>

<style scoped>
</style>
