export default {
  state: {
    isLoading: false,
    data: [],
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
    pagination: {
      sortBy: 'name',
      descending: false,
      page: 1,
      rowsPerPage: 5,
      rowsNumber: 99999,
    },
  },
  mutations: {
    updateOrganizations(state, organizations) {
      state.data = organizations;
    },
    updatePagination(state, pagination) {
      state.pagination = pagination;
      state.pagination.page = Number(state.pagination.page);
    },
    updateRowsNumber(state, count) {
      state.pagination.rowsNumber = count;
    }
  },
  actions: {
    indexOrganizations(context, params){
      this._vm.$api.organizations
        .index(params)
        .then(
          (response) => {
            context.commit('updateOrganizations', response.data.data.map(i => i.attributes));
            context.commit('updatePagination', response.data.meta.pagination);
          }).finally(() => (context.state.isLoading = false));
    },
    deleteOrganization(context, id){
      this.$api.organizations
        .destroy(id)
        .then(
          response => {
            context.dispatch('indexOrganizations');
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
