<template lang="pug">
  q-dialog(v-model="isShowDialog" @hide="afterHide()")
    q-card(style="width: 400px; max-width: 80vw;")
      DeviceForm(:device="device")
</template>

<script>
import DeviceForm from './form'

export default {
  components: {
    DeviceForm,
	},
  data: function() {
    return {
      isShowDialog: true,
      device: this.getDevice(),
    }
  },
  methods: {
    getDevice() {
      this.$api.devices
        .show(this.$route.params.id)
        .then(
          response => {
            this.device = response.data.data.attributes;
          },
          errors => {
            this.$q.notify({
              color: 'negative',
              message: errors.response.data
            });
          }
        )
    },
    afterHide() {
      this.$router.push("/staffs/dashboard/devices");
    },
  },
  mounted() {
    this.$eventBus.$on('needCloseDialog', () => {
      this.isShowDialog = false;
    });
  },
}
</script>
