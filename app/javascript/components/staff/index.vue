<template lang="pug">
  .staff
    Navbar(:userType="'staff'" :userEmail="userEmail")
    Dashboard
</template>

<script>
import Navbar from '../common/nav';
import Dashboard from './dashboard/organizations';

export default {
  components: {
    Navbar,
    Dashboard
  },
  props: {
    userEmail: {
      type: String,
      default: '',
    },
  },
}
</script>

<style scoped>
</style>
