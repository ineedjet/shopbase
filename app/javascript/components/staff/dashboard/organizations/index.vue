<template lang="pug">
  .container.mx-auto.flex
    OrganizationNewForm
    OrganizationList(:organizations="organizations")
</template>

<script>
import OrganizationNewForm from './form';
import OrganizationList from './list';

export default {
  components: {
    OrganizationNewForm,
    OrganizationList,
  },
  props: ['organizations']
}
</script>

<style scoped>
</style>
