<template lang="pug">
  q-layout(view='hhh lpR fFf')
    Navbar(:userType="'staff'" :userEmail="userEmail")
    q-drawer.q-ma-sm(show-if-above side="left" bordered content-class="flex flex-col")
      q-btn(@click="$router.push('/staffs/dashboard/staffs')") Staffs
      q-btn(@click="$router.push('/staffs/dashboard/clients')") Clients
      q-btn(@click="$router.push('/staffs/dashboard/organizations')") Organizations
      q-btn(@click="$router.push('/staffs/dashboard/hardwares')") Hardwares
    q-page-container
      router-view
</template>

<script>
import Navbar from '../common/nav';

export default {
  components: {
    Navbar,
    // Dashboard
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
