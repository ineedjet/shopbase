<template lang="pug">
  table.clients.shadow.bg-gray-100.my-2.rounded
    ClientItem(v-for="item in clients" :client="item")
</template>

<script>
import ClientItem from './client-item';

export default {
  components: {
    ClientItem
  },
  props: ['clients']
}
</script>

<style scoped>
</style>
