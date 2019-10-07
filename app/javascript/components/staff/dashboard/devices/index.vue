<template lang="pug">
  .container.mx-auto.flex
    DeviceNewForm
    DeviceList(:devices="devices")
</template>

<script>
import DeviceNewForm from './form';
import DeviceList from './list';

export default {
  components: {
    DeviceNewForm,
    DeviceList,
  },
  props: ['devices']
}
</script>

<style scoped>
</style>
