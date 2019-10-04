<template lang="pug">
  q-dialog(v-model="isShowDialog" @hide="afterHide()")
    q-card(style="width: 400px; max-width: 80vw;")
      StaffForm(:staff="staff")
</template>

<script>
import StaffForm from './form'

export default {
  components: {
    StaffForm,
	},
  data: function() {
    return {
      isShowDialog: true,
      staff: this.getStaff(),
    }
  },
  methods: {
    getStaff() {
      this.$api.staffs
        .show(this.$route.params.id)
        .then(
          response => {
            this.staff = response.data.data.attributes;
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
      this.$router.push("/staffs/dashboard/staffs");
    },
  },
  mounted() {
    this.$eventBus.$on('needCloseDialog', () => {
      this.isShowDialog = false;
    });
  },
}
</script>
