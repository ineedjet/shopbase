<template lang="pug">
  q-layout(view='hhh lpR fFf')
    Navbar(:userType="'staff'" :userEmail="userEmail")
    q-drawer.q-ma-sm(show-if-above side="left" bordered content-class="flex flex-col")
      q-btn(@click="$router.push('Staffs')") Staffs
      q-btn(@click="$router.push('Clients')") Clients
      q-btn(@click="$router.push('Organizations')") Organizations
      q-btn(@click="$router.push('Hardwares')") Hardwares
    q-page-container
      router-view
</template>

<script>
import Navbar from '../common/nav';
// import Dashboard from './dashboard/staffs';

// import Staffs from './dashboard/staffs/staffs';
// import Clients from './dashboard/staffs/clients';
// import Organizations from './dashboard/staffs/organizations';
// import Hardwares from './dashboard/staffs/hardwares';

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
