<template lang="pug">
  .app
    p {{ second_message }}
</template>

<script>
export default {
  data: function () {
    return {
      message: "Hello Vue!",
      second_message: "Bye!"
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
