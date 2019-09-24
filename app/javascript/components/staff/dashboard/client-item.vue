<template lang="pug">
  .client.shadow.bg-white.flex.flex-col.my-2.p-4.rounded
    h5.font-bold {{ client.fullname }}
    p {{ client.phone }}
    p {{ client.email }}
</template>

<script>
export default {
  props: ['client']
}
</script>

<style scoped lang="scss">
</style>
