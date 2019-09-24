<template lang="pug">
  .form-group
    label(for="fullname") Fullname
    input(type="text" id="fullname" v-model="fullname")
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
