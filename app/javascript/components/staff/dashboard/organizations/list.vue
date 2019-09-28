<template lang="pug">
  q-spinner-bars(v-if="is_loading")
  table.organizations.shadow.bg-gray-100.my-2.rounded(v-else)
    OrganizationItem(v-for="item in organizations" :organization="item" :key="item.id")
</template>

<script>
import OrganizationItem from './item';

export default {
  components: {
    OrganizationItem
  },
  data() {
    return {
      organizations: this.getOrganizationsList(),
      is_loading: true
    };
  },
  methods: {
    getOrganizationsList() {
      this.$api.organizations
        .index()
        .then(
          (response) => {
            this.organizations = response.data.data;
          }).finally(() => (this.is_loading = false));
    }
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
