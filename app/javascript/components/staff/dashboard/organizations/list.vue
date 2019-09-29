<template lang="pug">
  q-spinner-bars(v-if="is_loading")
  div(v-else)
    q-table.organizations.shadow.bg-gray-100.my-2.rounded(
        title=""
        :data="organizations"
        :columns="columns"
        row-key="id"
        no-data-label="Empty list of organization."
      )
      template(v-slot:body-cell-action="props")
        q-td(:props="props")
          q-btn(icon="fas fa-trash" @click="deleteOrganization(props.row)" method="delete")
</template>

<script>
export default {
  data() {
    return {
      is_loading: true,
      organizations: this.getOrganizationsList(),
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
        { name: 'inn', label: 'INN', field: 'inn' },
        { name: 'ogrn', label: 'OGRN', field: 'ogrn' },
        { name: 'action', label: 'actions', align: 'left' }
      ],
    };
  },
  methods: {
    getOrganizationsList() {
      this.$api.organizations
        .index()
        .then(
          (response) => {
            this.organizations = response.data.data.map(i => i.attributes);
          }).finally(() => (this.is_loading = false));
    },
    deleteOrganization(organization) {
      this.$api.organizations
        .destroy(organization.id)
        .then(
          response => {
            this.getOrganizationsList();
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
    this.$eventBus.$on('createOrganization', () => {
      this.getOrganizationsList();
    });
  },
}
</script>

<style scoped>
</style>
