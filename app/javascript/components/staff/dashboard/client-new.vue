<template lang="pug">
  .form.bg-white.m-2.p-4.rounded.shadow-lg
    h5.font-bold.text-2xl New Client !
    InputEmail
    InputFullname
    InputPhone
    .submit
      input(type="submit" value="Create" @click="SaveNewClient")
</template>

<script>
import InputEmail from './form/input-email'
import InputFullname from './form/input-fullname'
import InputPhone from './form/input-phone'

export default {
  components: {
    InputEmail,
    InputFullname,
    InputPhone,
  },
  data: function () {
    return {
      errors: {
        // email: 'Такой email уже существует',
        // fullname: 'Чего такой короткий?',
        // phone: 'Такой телефон уже существует',
      }
    }
  },
  methods: {
    SaveNewClient() {
      this.$eventBus.$emit('createClient');
    }
  }
}
</script>

<style scoped>
</style>
