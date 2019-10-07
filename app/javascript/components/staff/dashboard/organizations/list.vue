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
  data() {
    return {
      isLoading: true,
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
  computed: {
    filter() {
      return this.$store.state.filter
    },
  },
  methods: {
    getOrganizationsList() {
      this.$api.organizations
        .index()
        .then(
          (response) => {
            this.organizations = response.data.data.map(i => i.attributes);
          }).finally(() => (this.isLoading = false));
    },
    doEditDialog(row) {
      this.$router.push({ path: `${this.$route.path}/${row.id}/edit` })
    },
    deleteOrganization(organization) {
      this.$api.organizations
        .destroy(organization.id)
        .then(
          response => {
            this.getOrganizationsList();
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
    this.$eventBus.$on('needUpdateOrganizationList', () => {
      this.getOrganizationsList();
    });
  },
}
</script>

<style scoped>
</style>
