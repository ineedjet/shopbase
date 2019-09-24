<template lang="pug">
  .form-group
    label(for="email") Email
    input(type="email" id="email" v-model="email")
    span.error(v-if="error") {{ error }}
</template>

<script>
export default {
  props: ['error'],
  data: function () {
    return {
      email: ''
    }
  }
}
</script>

<style scoped lang="scss">

</style>
