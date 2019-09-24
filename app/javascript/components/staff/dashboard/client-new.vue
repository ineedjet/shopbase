<template lang="pug">
  .form.bg-white.m-2.p-4.rounded.shadow-lg
    h5.font-bold.text-2xl New Client !
    InputEmail
    InputFullname
    InputPhone
    .submit
      input(type="submit" value="Create" @click="SaveNewClient")
    span.error(v-for="(error, name) in errors") {{ name }} : {{ error }}
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
      client: {},
      errors: [],
    }
  },
  methods: {
    SaveNewClient() {
      this.$api.clients
        .create({ fullname: this.client.fullname, phone: this.client.phone, email: this.client.email })
        .then(
          (response) => {
            this.client = {};
            this.$eventBus.$emit('createClient');
          },
          (errors) => {
            this.errors = errors.response.data;
          },
        );
    }
  },
  mounted() {
    this.$eventBus.$on('inputEmailChange', (email) => {
      this.client.email = email;
    });
    this.$eventBus.$on('inputFullnameChange', (fullname) => {
      this.client.fullname = fullname;
    });
    this.$eventBus.$on('inputPhoneChange', (phone) => {
      this.client.phone = phone;
    });
  }
}
</script>

<style scoped>
</style>
