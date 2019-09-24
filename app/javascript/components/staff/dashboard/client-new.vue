<template lang="pug">
  .form.bg-gray-100.m-2.p-4.rounded.shadow-lg
    h5.font-bold.text-2xl New Client
    input(type="hidden" name="id" v-model="client.id")
    
    .form-group
      label(for="email") Email
      input(type="email" id="email" v-model="client.email")
      span.error(v-if="errors.email") {{ errors.email }}

    .form-group
      label(for="fullname") Fullname
      input(type="text" id="fullname" v-model="client.fullname")
      span.error(v-if="errors.fullname") {{ errors.fullname }}
    
    .form-group
      label(for="phone") Phone
      input(type="text" id="phone" v-model="client.phone")
      span.error(v-if="errors.phone") {{ errors.phone }}
    
    .submit
      input(type="submit" value="Create")
</template>

<script>
export default {
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
