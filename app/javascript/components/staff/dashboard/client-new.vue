<template lang="pug">
  .form.bg-white.m-2.p-4.rounded.shadow-lg
    h5.font-bold.text-2xl New Client !
    input(type="hidden" name="id" v-model="client.id")
    
    InputEmail(:error="errors.email")
    InputFullname(:error="errors.fullname")
    InputPhone(:error="errors.phone")
    
    .submit
      input(type="submit" value="Create")
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
  props: ['client'],
  data: function () {
    return {
      errors: {
        // email: 'Такой email уже существует',
        // fullname: 'Чего такой короткий?',
        // phone: 'Такой телефон уже существует',
      }
    }
  }
}
</script>

<style scoped>
  .form-group {
    @apply .py-2;
  }
  input {
    @apply .my-1;
  }
  .error {
    @apply .bg-red-400 .p-1 .my-1 .rounded .text-white;
  }
</style>
