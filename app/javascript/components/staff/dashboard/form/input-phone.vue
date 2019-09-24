<template lang="pug">
  .form-group
    label(for="phone") Phone
    input(
      type="text" id="phone"
      v-model="phone"
      v-bind:class="valid_class"
      v-on:blur="validatePhone"
      v-on:keyup="validatePhone"
      )
    span.error(v-for="error in errors") {{ error }}
</template>

<script>
import eventBus from '../../event-bus';

const  phoneRegex= /(?:\(?\+\d{2}\)?\s*)?\d+(?:[ -]*\d+)*$/;

export default {
  data: function () {
    return {
      phone: '',
      errors: [],
      valid_class: ''
    }
  },
  methods: {
    isNotEmpty() {
      return this.phone.length > 0;
    },
    isValidPhone() {
      return phoneRegex.test(this.phone);
    },
    validatePhone() {
      this.errors = [];
      if (!this.isNotEmpty()) { this.errors.push('Can not be blank') } ;
      if (!this.isValidPhone()) { this.errors.push('No valid phone') } ;
      this.valid_class = (this.errors.length > 0 ? 'invalid' : 'valid')
    }
  },
  mounted() {
    eventBus.$on('createClient', () => {
      this.phone = '';
      this.errors = [];
      this.valid_class = '';
    });
  }
}
</script>

<style scoped lang="scss">
</style>
