<template>
  <v-dialog max-width="300" v-model="dialog">
    <v-card>
      <v-toolbar elevation="1" color="secondary" dark>
        <v-toolbar-title class="google-sans-regular">
          {{ state ? "Update state" : "Add new state" }}
        </v-toolbar-title>
      </v-toolbar>
      <v-card-text class="pt-2">
        <v-form v-model="valid" ref="form" lazy-validation>
          <v-text-field
            v-model="name"
            :rules="nameRules"
            color="secondary"
            label="State name"
            :append-icon="
              valid ? 'mdi-checkbox-marked-circle' : 'mdi-close-circle'
            "
            @click:append="_addOrUpdateState"
          ></v-text-field>
        </v-form>
      </v-card-text>
    </v-card>
  </v-dialog>
</template>

<script>
import { mapActions } from "vuex";
export default {
  name: "AddStateDialog",
  data() {
    return {
      dialog: false,
      stateId: null,
      state: null,
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
        this.name = null;
        this.stateId = null;
        this.state = null;
      }
    },

    state(v) {
      if (v) {
        this.name = v.stateName;
        this.stateId = v.stateId;
      }
    },
  },

  methods: {
    ...mapActions("state", ["addState", "updateState"]),
    async _addOrUpdateState() {
      try {
        const { name } = this;
        if (this.stateId)
          await this.updateState({ stateId: this.stateId, name });
        else await this.addState({ name });
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