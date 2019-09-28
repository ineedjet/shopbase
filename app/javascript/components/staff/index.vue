<template lang="pug">
  .staff
    Navbar
    Dashboard
</template>

<script>
import Navbar from '../common/nav';
import Dashboard from './dashboard';

export default {
  components: {
    Navbar,
    Dashboard
  },
  data: function () {
    return {
      false
    }
  }
}
</script>

<style scoped>
</style>
