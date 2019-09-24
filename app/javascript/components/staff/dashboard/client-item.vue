<template lang="pug">
  tr.client
    td.font-bold {{ client.id }}
    td.font-bold {{ client.fullname }}
    td {{ client.phone }}
    td {{ client.email }}
</template>

<script>
export default {
  props: ['client']
}
</script>

<style scoped lang="scss">
  tr:hover {
    @apply .bg-white;
  }
  td {
    @apply .px-2 .py-1;
  }
</style>
