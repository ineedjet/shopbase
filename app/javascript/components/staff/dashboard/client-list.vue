<template lang="pug">
  .clients
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
