<template lang="pug">
  .container.mx-auto.flex
    HardwareNewForm
    HardwareList(:hardwares="hardwares")
</template>

<script>
import HardwareNewForm from './form';
import HardwareList from './list';

export default {
  components: {
    HardwareNewForm,
    HardwareList,
  },
  props: ['hardwares']
}
</script>

<style scoped>
</style>
