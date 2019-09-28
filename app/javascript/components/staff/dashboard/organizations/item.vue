<template lang="pug">
  tr.organization
    td.font-bold {{ organization.id }}
    td.font-bold {{ organization.attributes.name }}
    td {{ organization.attributes.kind }}
    td {{ organization.attributes.inn }}
    td {{ organization.attributes.ogrn }}
</template>

<script>
export default {
  props: ['organization']
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
