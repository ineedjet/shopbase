<template lang="pug">
  .container.mx-auto.flex
    OrganizationNewForm
    OrganizationList(:organizaions="organizaion")
</template>

<script>
import OrganizationNewForm from './new';
import OrganizationList from './list';

export default {
  components: {
    OrganizationNewForm,
    OrganizationList,
  },
  props: ['organizaions']
}
</script>

<style scoped>
</style>
