<template lang="pug">
  q-spinner-bars(v-if="is_loading")
  div(v-else)
    q-table.staffs.shadow.bg-gray-100.my-2.rounded(
        title=""
        :data="staffs"
        :columns="columns"
        row-key="id"
        no-data-label="Empty list of staff."
      )
      template(v-slot:body-cell-action="props")
        q-td(:props="props")
          q-btn-group
            q-btn(icon="fas fa-edit" @click="doEditDialog(props.row)")
            q-btn(icon="fas fa-trash" @click="deleteStaff(props.row)" method="delete")
    q-dialog(v-model="$route.meta.showDialog" @before-hide="beforeHideDialog()")
      q-card(style="width: 400px; max-width: 80vw;")
        router-view(name="editForm")
</template>

<script>
import { required, minLength, email } from '../../../../utils/validations';
import { clone } from '../../../../utils/object';
import StaffEditForm from './edit'

export default {
  components: {
		StaffEditForm,
	},
  data() {
    return {
      is_loading: true,
      staffs: this.getStaffsList(),
      columns: [
        {
          name: 'id',
          required: true,
          label: 'ID',
          field: 'id',
          sortable: true,
        },
        {
          name: 'email',
          required: true,
          label: 'Email',
          align: 'left',
          field: 'email',
          sortable: true,
        },
        {
          name: 'fullname',
          required: true,
          label: 'Name',
          align: 'left',
          field: 'fullname',
          sortable: true,
        },
        {
          name: 'position',
          align: 'left',
          label: 'Position',
          field: 'position',
          sortable: true,
        },
        { name: 'action', label: 'actions', align: 'left' }
      ],
      isShowDialog: this.$route.meta.showDialog,
      // editRow: {},
    };
  },
  watch: {
    // "$route.meta"({ showDialog }) {
    //   this.isShowDialog = showDialog;
    // },
    // showDialog: function() {
    //   console.log("this.$route.meta.showDialog = ", this.$route.meta.showDialog);
    //   console.log("this.showDialog = ", this.showDialog);
    // }
  },
  methods: {
    getStaffsList() {
      this.$api.staffs
        .index()
        .then(
          (response) => {
            this.staffs = response.data.data.map(i => i.attributes);
          }).finally(() => (this.is_loading = false));
    },
    doEditDialog(row) {
      // this.editRow = clone(row);
      this.$router.push({ path: `${this.$route.path}/${row.id}/edit` })
    },
    beforeHideDialog(){
      console.log("afterHideDialog");
      this.$router.push("/staffs/dashboard/staffs");
    },
    escapeKey(){
      console.log("ESC");
      this.$router.push("/staffs/dashboard/staffs");
    },
    saveStaff() {
      console.log("SAVE!")
    },
    deleteStaff(staff) {
      this.$api.staffs
        .destroy(staff.id)
        .then(
          response => {
            this.getStaffsList();
            this.$q.notify({
              icon: 'fas fa-trash',
              color: 'positive',
              message: 'Successfully deleted'
            })
          },
          errors => {
            this.$q.notify({
              color: 'negative',
              message: errors.response.data
            });
          })
    },
    required,
    minLength,
    email,
  },
  mounted() {
    this.$eventBus.$on('needUpdateStaffList', () => {
      this.getStaffsList();
    });
  },
}
</script>
