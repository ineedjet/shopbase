<template lang="pug">
  nav.flex.justify-between.bg-white
    a(href="/")
      img.mx-2.my-2.h-8(v-bind:src="require('images/shopbase_logo.png')")
    div.flex.items-center
      p {{ user.type }}: {{ user.email }}
      a.flex.items-center.h-full.px-4(:href="'/' + user.type + 's/devise/sign_out'", 'data-method'="delete") Sign out
</template>

<script>
export default {
  props: ['user']
}
</script>

<style scoped lang="scss">
</style>
