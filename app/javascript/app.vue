<template lang="pug">
  .app
    p {{ second_message }}
      span 123
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

<style scoped lang="scss">
$var: #00f;
p {
  font-size: 2em;
  text-align: center;

  span {
    color: $var;
  }
}
</style>
