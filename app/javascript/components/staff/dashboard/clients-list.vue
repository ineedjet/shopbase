<template lang="pug">
  table.clients.shadow.bg-gray-100.my-2.rounded
    ClientItem(v-for="item in clients" :client="item" :key="item.id")
</template>

<script>
import ClientItem from './client-item';

export default {
  components: {
    ClientItem
  },
  data() {
    return {
      clients: this.getClientsList(),
    };
  },
  methods: {
    getClientsList() {
      this.$api.clients
        .get_list()
        .then(
          (response) => {
            this.clients = response.data;
          });
    }
  },
  mounted() {
    this.$eventBus.$on('createClient', () => {
      this.getClientsList();
    });
  },
}
</script>

<style scoped>
</style>
