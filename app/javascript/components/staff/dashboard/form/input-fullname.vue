<template lang="pug">
  .form-group
    label(for="fullname") Fullname
    input(
      type="text" id="fullname" 
      v-model="fullname"
      v-bind:class="valid_class"
      v-on:blur="validateFullname"
      )
    span.error(v-for="error in errors") {{ error }}
</template>

<script>
import eventBus from '../../event-bus';

export default {
  data: function () {
    return {
      fullname: '',
      errors: [],
      valid_class: ''
    }
  },
  methods: {
    isNotEmpty() {
      return this.fullname.length > 0;
    },
    haveMoreThan5Chars() {
      return this.fullname.length > 5;
    },
    validateFullname() {
      this.errors = [];
      if (!this.isNotEmpty()) { this.errors.push('Can not be blank') } ;
      if (!this.haveMoreThan5Chars()) { this.errors.push('Must have more than 5 characters') } ;
      this.valid_class = (this.errors.length > 0 ? 'invalid' : 'valid')
    }
  },
  mounted() {
    eventBus.$on('createClient', () => {
      this.fullname = '';
      this.errors = [];
    });
  }
}
</script>

<style scoped lang="scss">

</style>
