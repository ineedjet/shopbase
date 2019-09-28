<template lang="pug">
  nav.flex.justify-between.bg-white
    a(href="/")
      img.mx-2.my-2.h-8(v-bind:src="require('images/shopbase_logo.png')")
    div.flex.items-center
      span {{ userType }}: {{ userEmail }}
      a.flex.items-center.h-full.px-4(:href="'/' + userType + 's/devise/sign_out'", 'data-method'="delete") Sign out
</template>

<script>
export default {
  props: ['userType', 'userEmail']
}
</script>

<style scoped lang="scss">
</style>
