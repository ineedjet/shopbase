<template lang="pug">
  table.organizations.shadow.bg-gray-100.my-2.rounded
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
    };
  },
  methods: {
    getOrganizationsList() {
      this.$api.organizations
        .index()
        .then(
          (response) => {
            this.organizations = response.data.data;
          });
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
