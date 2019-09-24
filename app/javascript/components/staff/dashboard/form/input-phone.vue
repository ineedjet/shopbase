<template lang="pug">
  .form-group
    label(for="phone") Phone
    input(type="text" id="phone" v-model="phone")
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
