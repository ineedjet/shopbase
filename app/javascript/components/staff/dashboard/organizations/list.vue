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
            q-btn(
              v-for="action in actions"
              :icon="action.icon"
              @click="doAction(action.name,props.row)"
            )
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
    actions()     { return this.$store.state.organizations.actions },
  },
  methods: {
    requestData(requestProp){
      let { page, rowsPerPage, sortBy, descending } = requestProp.pagination
      let filter = requestProp.filter
      this.$store.dispatch('indexOrganizations', { page, rowsPerPage, sortBy, descending, filter })
    },
    doAction(actionName, row){
      if (typeof this[actionName] === 'function') this[actionName](row)
    },
    edit(organization) {
      this.$router.push({ path: `${this.$route.path}/${organization.id}/edit` })
    },
    delete(organization) {
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
  mounted(){
    this.$cable.subscribe({ channel: 'StaffChannel', room: 'organizations' });
  },
  channels: {
    StaffChannel: {
      connected() {
        console.log("! connected")
      },
      rejected() {},
      received(data) {
        this.$refs.table.requestServerInteraction()
      },
      disconnected() {
        console.log("! disconnected")
      },
    }
  },
}
</script>
