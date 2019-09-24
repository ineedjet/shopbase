<template lang="pug">
  Navbar(:user="client")
</template>

<script>
import Navbar from '../common/nav.vue';

export default {
  components: {
    Navbar
  },
  data: function () {
    return {
      client: {
        id: 1,
        type: "client",
        email: "svetoz@gmail.com",
      }
    }
  }
}
</script>

<style scoped>
</style>
