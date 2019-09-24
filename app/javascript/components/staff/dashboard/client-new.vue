<template lang="pug">
  .form.bg-white.m-2.p-4.rounded.shadow-lg
    h5.font-bold.text-2xl
    
    .form-group
      label(for="email") Email
      input(
        type="email" id="email" 
        v-model="client.email"
        v-bind:class="valid_class.email"
        v-on:blur="ValidateEmail"
        v-on:input="errors.email.length>0 ? ValidateEmail() : {}"
        )
      span.error(v-for="error in errors.email") {{ error }}

    .form-group
      label(for="fullname") Fullname
      input(
        type="text" id="fullname" 
        v-model="client.fullname"
        v-bind:class="valid_class.fullname"
        v-on:blur="ValidateFullname"
        v-on:input="errors.fullname.length>0 ? ValidateFullname() : {}"
        )
      span.error(v-for="error in errors.fullname") {{ error }}
      
    .form-group
      label(for="phone") Phone
      input(
        type="text" id="phone"
        v-model="client.phone"
        v-bind:class="valid_class.phone"
        v-on:blur="ValidatePhone"
        v-on:input="errors.phone.length>0 ? ValidatePhone() : {}"
        )
      span.error(v-for="error in errors.phone") {{ error }}

    .submit
      input(type="submit" value="Create" @click="SaveNewClient")
</template>

<script>
const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
const phoneRegex= /(?:\(?\+\d{2}\)?\s*)?\d+(?:[ -]*\d+)*$/;

export default {
  data: function () {
    return {
      client: {
        email: '',
        fullname: '',
        phone: '',
      },
      errors: {
        email: [],
        fullname: [],
        phone: [],
      },
      valid_class: {
        email_: '',
        fullname: '',
        phone: '',
      }
    }
  },
  methods: {
    EmailIsNotEmpty() {
      return this.client.email.length > 0;
    },
    EmailIsValid() {
      return emailRegex.test(this.client.email);
    },
    FullnameIsNotEmpty() {
      return this.client.fullname.length > 0;
    },
    FullnameHaveMoreThan5Chars() {
      return this.client.fullname.length > 5;
    },
    PhoneIsNotEmpty() {
      return this.client.phone.length > 0;
    },
    PhoneisValid() {
      return phoneRegex.test(this.client.phone);
    },
    ValidateEmail() {
      this.errors.email = [];
      if (!this.EmailIsNotEmpty()) { this.errors.email.push('Can not be blank') } ;
      if (!this.EmailIsValid()) { this.errors.email.push('No valid email') } ;
      if (this.errors.email.length <= 0) {
        this.$api.clients
          .validate({ email: this.client.email })
          .then(
            () => {
              this.errors.email = [];
            },
            (errors) => {
              this.errors.email = errors.response.data.email;
            },
          );
      }
      this.valid_class.email = (this.errors.email.length > 0 ? 'invalid' : 'valid')
    },
    ValidateFullname() {
      this.errors.fullname = [];
      if (!this.FullnameIsNotEmpty()) { this.errors.fullname.push('Can not be blank') } ;
      if (!this.FullnameHaveMoreThan5Chars()) { this.errors.fullname.push('Must have more than 5 characters') } ;
      this.valid_class.fullname = (this.errors.fullname.length > 0 ? 'invalid' : 'valid')
    },
    ValidatePhone() {
      this.errors.phone = [];
      if (!this.PhoneIsNotEmpty()) { this.errors.phone.push('Can not be blank') } ;
      if (!this.PhoneisValid()) { this.errors.phone.push('No valid phone') } ;
      if (this.errors.phone.length <= 0) {
        this.$api.clients
          .validate({ phone: this.client.phone })
          .then(
            () => {
              this.errors.phone = [];
            },
            (errors) => {
              this.errors.phone = errors.response.data.phone;
            },
          );
      }
      this.valid_class.phone = (this.errors.phone.length > 0 ? 'invalid' : 'valid')
    },
    ClearForm() {
      this.client = {
        email: '',
        fullname: '',
        phone: '',
      };
      this.errors = {
        email: [],
        fullname: [],
        phone: [],
      };
      this.valid_class = {
        email_: '',
        fullname: '',
        phone: '',
      };
    },
    SaveNewClient() {
      this.$api.clients
        .create({ fullname: this.client.fullname, phone: this.client.phone, email: this.client.email })
        .then(
          (response) => {
            this.$eventBus.$emit('createClient');
            this.ClearForm();
          },
          (errors) => {
            this.errors = errors.response.data;
          },
        );
    }
  }
}
</script>

<style scoped>
</style>
