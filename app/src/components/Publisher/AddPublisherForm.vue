<template>
  <v-row justify="center">
    <v-dialog v-model="dialog" width="500" persistent>
      <v-card style="cursor: initial">
        <v-toolbar elevation="1" color="secondary" dark>
          <v-toolbar-title class="google-sans-regular"
            >Add new publisher</v-toolbar-title
          >
          <v-spacer></v-spacer>
          <v-btn @click="dialog = false" icon>
            <v-icon>mdi-close</v-icon></v-btn
          >
        </v-toolbar>
        <v-card-text class="pb-0">
          <v-form class="pt-4" ref="form" v-model="valid" lazy-validation>
            <span class="subheader">Publisher name & Foundation year</span>
            <v-row>
              <v-col>
                <v-text-field
                  v-model="name"
                  :rules="nameRules"
                  color="secondary"
                  label="Publisher name"
                  outlined
                  dense
                ></v-text-field>
              </v-col>
              <v-col>
                <v-text-field
                  v-model="foundationYear"
                  :rules="foundationYearRules"
                  type="number"
                  color="secondary"
                  label="Foundation Year"
                  outlined
                  dense
                ></v-text-field>
              </v-col>
            </v-row>
            <span class="subheader">Description</span>
            <v-row>
              <v-col>
                <v-textarea
                  rows="4"
                  color="secondary"
                  label="Description"
                  :rules="descriptionRules"
                  v-model="description"
                  no-resize
                  outlined
                  dense
                ></v-textarea>
              </v-col>
            </v-row>
            <span class="subheader">Publisher's logo</span>
            <v-row>
              <v-col>
                <v-file-input
                  v-model="imageData"
                  :rules="imageRules"
                  outlined
                  accept="image/png, image/jpeg, image/bmp"
                  prepend-icon="mdi-image"
                  label="Select an image"
                  dense
                ></v-file-input>
              </v-col>
            </v-row>
          </v-form>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="primary" text @click="dialog = false"> Cancel </v-btn>
          <v-btn
            color="secondary"
            :disabled="!valid"
            text
            @click="_addPublisher"
          >
            Add new</v-btn
          >
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-row>
</template>

<script>
import { mapActions } from "vuex";
export default {
  name: "AddPublisherForm",
  data() {
    return {
      name: null,
      description: null,
      foundationYear: null,
      imageData: null,
      dialog: false,

      valid: true,

      nameRules: [
        (v) => (!!v && v.length > 0) || "Name is required",
        (v) =>
          (!!v && v.length < 70) || "Name can't be longer than 70 characters",
      ],
      foundationYearRules: [
        (v) =>
          !v ||
          parseInt(v) < 3000 ||
          "Foundation year can't be bigger than 3000 years",
        (v) =>
          !v ||
          parseInt(v) > 1 ||
          "Foundation year can't be smaller than 1 year",
      ],
      descriptionRules: [
        (v) =>
          !v ||
          v.length < 1000 ||
          "Description can't be longer than 1000 charachter",
      ],
      imageRules: [
        (v) => !v || v.size < 4000000 || "Image size should be less than 5 MB!",
      ],
    };
  },

  watch: {
    dialog: function (newValue) {
      if (!newValue) {
        this.name = null;
        this.description = null;
        this.foundationYear = null;
        this.imageData = null;
        this.resetValidation();
      }
    },
  },

  methods: {
    ...mapActions("publisher", ["addPublisher"]),
    async _addPublisher() {
      try {
        this.validate();
        const { name, description, foundationYear, imageData } = this;
        console.log(imageData);
        await this.addPublisher({
          name,
          description,
          foundationYear,
          imageData,
        });
        this.dialog = false;
      } catch (err) {
        console.error(err);
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
.v-application--is-ltr textarea::-webkit-scrollbar {
  display: none;
}
</style>