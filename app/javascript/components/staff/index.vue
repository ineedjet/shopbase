<template lang="pug">
  q-layout(view='hhh lpR fFf')
    Navbar(:userType="'staff'" :userEmail="userEmail")
    q-page-container
      q-page
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
