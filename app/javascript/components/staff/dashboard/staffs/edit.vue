<template lang="pug">
  StaffForm(
    title="Edit Staff" 
    action="update"
    :staff="staff"
    )
    //- @sended="handleClose()"
</template>

<script>
import StaffForm from './form'

export default {
  components: {
    StaffForm,
	},
  props: {
    staff: Object,
  },
  // methods: {
  //   handleClose() {
  //     this.$router.push("/staffs/dashboard/staffs");
  //   },
  // }
}
</script>