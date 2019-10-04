<template lang="pug">
  q-dialog(v-model="isShowDialog" @hide="afterHide()")
    q-card(style="width: 400px; max-width: 80vw;")
      HardwareForm(:hardware="hardware")
</template>

<script>
import HardwareForm from './form'

export default {
  components: {
    HardwareForm,
	},
  data: function() {
    return {
      isShowDialog: true,
      hardware: this.getHardware(),
    }
  },
  methods: {
    getHardware() {
      this.$api.hardwares
        .show(this.$route.params.id)
        .then(
          response => {
            this.hardware = response.data.data.attributes;
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
      this.$router.push("/staffs/dashboard/hardwares");
    },
  },
  mounted() {
    this.$eventBus.$on('needCloseDialog', () => {
      this.isShowDialog = false;
    });
  },
}
</script>
