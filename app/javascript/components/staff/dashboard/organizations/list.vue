<template lang="pug">
  q-spinner-bars(v-if="isLoading")
  div(v-else)
    TableFilter
    q-table.organizations.shadow.bg-gray-100.my-2.rounded(
        title=""
        :data="organizations"
        :columns="columns"
        row-key="id"
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
    organizations() { return this.$store.state.organizations.organizations },
    isLoading()     { return this.$store.state.organizations.isLoading },
  },
  methods: {
    doEditDialog(row) {
      this.$router.push({ path: `${this.$route.path}/${row.id}/edit` })
    },
    deleteOrganization(organization) {
      this.$store.dispatch('deleteOrganization', organization.id)
    }
  },
  created() {
    this.$store.dispatch('indexOrganizations')
    this.$eventBus.$on('needUpdateOrganizationList', () => {
      this.$store.dispatch('indexOrganizations')
    });
  },
}
</script>
