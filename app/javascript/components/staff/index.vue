<template lang="pug">
  .staff
    Navbar(:user="staff")
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
      staff: {
        id: 1,
        type: "staff",
        email: "svetoz@gmail.com",
        phone: "1234567890",
        fullname: "Dmitry Dudin"
      }
    }
  }
}
</script>

<style scoped>
</style>
