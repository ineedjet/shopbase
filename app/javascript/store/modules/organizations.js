export default {
  state: {
    isLoading: false,
    data: [],
    columns: [],
    pagination: {},
    actions: [],
  },
  mutations: {
    updateOrganizations(state, organizations) {
      state.data = organizations;
    },
    updatePagination(state, pagination) {
      state.pagination = pagination;
      state.pagination.page = Number(state.pagination.page);
    },
    updateColumns(state, value) {
      state.columns = value
    },
    updateActions(state, value) {
      state.actions = value
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
            context.commit('updateColumns', response.data.meta.columns);
            context.commit('updateActions', response.data.meta.actions);
          }).finally(() => (context.state.isLoading = false));
    },
    deleteOrganization(context, id){
      this._vm.$api.organizations
        .destroy(id)
        .then(
          response => {
            context.dispatch('indexOrganizations');
            this._vm.$q.notify({
              icon: 'fas fa-trash',
              color: 'positive',
              message: 'Successfully deleted'
            })
          },
          errors => {
            this._vm.$q.notify({
							color: 'negative',
							message: errors.response.data
						});
          })
    },
  },
}
