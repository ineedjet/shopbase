<template lang="pug">
  .form-group
    label(for="email") Email
    input(
      type="email" id="email" 
      v-model="email"
      v-bind:class="valid_class"
      v-on:blur="validateEmail"
      )
    span.error(v-for="error in errors") {{ error }}
</template>

<script>
import eventBus from '../../event-bus';

const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

export default {
  data: function () {
    return {
      email: '',
      errors: [],
      valid_class: ''
    }
  },
  methods: {
    isNotEmpty() {
      return this.email.length > 0;
    },
    isValidEmail() {
      return emailRegex.test(this.email);
    },
    validateEmail() {
      this.errors = [];
      if (!this.isNotEmpty()) { this.errors.push('Can not be blank') } ;
      if (!this.isValidEmail()) { this.errors.push('No valid email') } ;
      this.valid_class = (this.errors.length > 0 ? 'invalid' : 'valid')
    }
  },
  mounted() {
    eventBus.$on('createClient', () => {
      this.email = '';
    });
  }
}
</script>

<style scoped lang="scss">
</style>
