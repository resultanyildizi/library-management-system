<template>
  <v-dialog max-width="300" v-model="dialog">
    <v-card>
      <v-toolbar elevation="1" color="secondary" dark>
        <v-toolbar-title class="google-sans-regular"
          >Add new category</v-toolbar-title
        >
      </v-toolbar>
      <v-card-text class="pt-2">
        <v-form v-model="valid" ref="form" lazy-validation>
          <span class="caption">{{ parentName ? parentName : "Root" }}</span>
          <v-text-field
            v-model="name"
            :rules="nameRules"
            color="secondary"
            label="Category name"
            :append-icon="
              valid ? 'mdi-checkbox-marked-circle' : 'mdi-close-circle'
            "
            @click:append="_addCategory"
          ></v-text-field>
        </v-form>
      </v-card-text>
    </v-card>
  </v-dialog>
</template>

<script>
import { mapActions } from "vuex";
export default {
  name: "AddCategoryDialog",
  data() {
    return {
      dialog: false,
      parentId: null,
      parentName: null,
      name: null,
      nameRules: [
        (v) => (!!v && v.length > 1) || "Name is required",
        (v) =>
          (!!v && v.length < 50) || "Name must be shorter than 50 characters",
      ],
      valid: true,
    };
  },
  watch: {
    dialog: function (v) {
      if (!v) {
        this.resetValidation();
        this.parentId = null;
        this.name = null;
        this.parentName = null;
      }
    },
  },
  methods: {
    ...mapActions("category", ["addCategory"]),
    async _addCategory() {
      try {
        const { name, parentId } = this;
        await this.addCategory({ name, parentId });
        this.dialog = false;
        this.resetValidation();
      } catch (err) {
        console.log(err);
      }
    },
    validate() {
      this.$refs.form.validate();
    },
    resetValidation() {
      this.$refs.form.resetValidation();
    },
  },
};
</script>

<style>
</style>