export default {
  state: {
    isLoading: false,
    organizations: [],
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
  },
  mutations: {
    updateOrganizations(state, organizations) {
      state.organizations = organizations;
    }
  },
  actions: {
    indexOrganizations(context){
      this._vm.$api.organizations
        .index()
        .then(
          (response) => {
            context.commit('updateOrganizations', response.data.data.map(i => i.attributes));
          }).finally(() => (context.state.isLoading = false));
    },
    deleteOrganization(context, id){
      this.$api.organizations
        .destroy(id)
        .then(
          response => {
            dispatch('indexOrganizations');
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
}
