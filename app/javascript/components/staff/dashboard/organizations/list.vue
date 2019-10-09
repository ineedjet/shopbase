<template lang="pug">
  div
    TableFilter
    q-table.organizations.shadow.bg-gray-100.my-2.rounded(
      title=""
      ref="table"
      :data="organizations"
      :columns="columns"
      :filter="filter"
      row-key="id"
      binary-state-sort
      :rows-per-page-options="[5,10,20,100]"
      :loading="isLoading"
      :pagination.sync="pagination"
      @request="requestData"
      no-data-label="Empty list of organization."
    )
      template(v-slot:top)
        h5(v-if="filter")
          | Filtered by "{{ filter }}"
      template(v-slot:body-cell-action="props")
        q-td(:props="props")
          q-btn-group
            q-btn(icon="fas fa-edit" @click="doEditDialog(props.row)")
            q-btn(icon="fas fa-trash" @click="deleteOrganization(props.row)" method="delete")
    router-view(name="editForm")
</template>

<script>
import TableFilter from './filter'

export default {
  components: {
    TableFilter,
  },
  computed: {
    filter()        { return this.$store.state.organizationFilter.filter },
    columns()       { return this.$store.state.organizations.columns },
    organizations() { return this.$store.state.organizations.data },
    pagination:     {
                      get() { return this.$store.state.organizations.pagination},
                      set(value) { this.$store.commit("updatePagination",value) }
                    },
    isLoading()     { return this.$store.state.organizations.isLoading },
  },
  methods: {
    requestData(requestProp){
      let { page, rowsPerPage, sortBy, descending } = requestProp.pagination
      let filter = requestProp.filter
      this.$store.dispatch('indexOrganizations', { page, rowsPerPage, sortBy, descending, filter })
    },
    doEditDialog(row) {
      this.$router.push({ path: `${this.$route.path}/${row.id}/edit` })
    },
    deleteOrganization(organization) {
      this.$store.dispatch('deleteOrganization', organization.id)
    }
  },
  created() {
    this.requestData({
      pagination: this.pagination,
      filter: undefined
    });
    this.$eventBus.$on('needUpdateOrganizationList', () => {
      this.$refs.table.requestServerInteraction()
    });
  },
}
</script>
