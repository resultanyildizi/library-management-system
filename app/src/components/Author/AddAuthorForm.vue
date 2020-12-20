<template>
  <v-row justify="center">
    <v-dialog v-model="dialog" width="500" persistent>
      <v-card style="cursor: initial">
        <v-toolbar elevation="1" color="secondary" dark>
          <v-toolbar-title class="google-sans-regular">
            Add new author or translator
          </v-toolbar-title>
          <v-spacer></v-spacer>
          <v-btn @click="dialog = false" icon>
            <v-icon>mdi-close</v-icon></v-btn
          >
        </v-toolbar>
        <v-card-text class="pb-0">
          <v-form class="pt-4" ref="form" v-model="valid" lazy-validation>
            <span class="subheader">Full name & Birth year</span>
            <v-row>
              <v-col>
                <v-text-field
                  v-model="fullName"
                  :rules="fullNameRules"
                  color="secondary"
                  label="Person's full name"
                  outlined
                  dense
                ></v-text-field>
              </v-col>
              <v-col>
                <v-text-field
                  v-model="birthYear"
                  :rules="birthYearRules"
                  type="number"
                  color="secondary"
                  outlined
                  label="Person's birth year"
                  dense
                ></v-text-field>
              </v-col>
            </v-row>
            <span class="subheader">Country</span>
            <v-row>
              <v-col>
                <v-select
                  :items="getCountryNames"
                  v-model="countryName"
                  label="Country"
                  outlined
                  dense
                  color="secondary"
                ></v-select>
              </v-col>
            </v-row>

            <span class="subheader">Picture</span>
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
          <v-btn color="secondary" :disabled="!valid" text @click="_addAuthor">
            Add new</v-btn
          >
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-row>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
export default {
  name: "AddAuthorForm",
  data() {
    return {
      fullName: null,
      birthYear: null,
      imageData: null,
      countryId: null,
      dialog: false,

      valid: true,
      countryName: null,

      fullNameRules: [
        (v) => (!!v && v.length > 0) || "Full name is required",
        (v) =>
          (!!v && v.length < 100) ||
          "Full name can't be longer than 100 characters",
      ],
      birthYearRules: [
        (v) =>
          !v ||
          parseInt(v) < 3000 ||
          "Foundation year can't be bigger than 3000 years",
        (v) =>
          !v ||
          parseInt(v) > 1 ||
          "Foundation year can't be smaller than 1 year",
      ],

      imageRules: [
        (v) => !v || v.size < 4000000 || "Image size should be less than 5 MB!",
      ],
    };
  },

  watch: {
    dialog: function (newValue) {
      if (!newValue) {
        this.fullName = null;
        this.birthYear = null;
        this.imageData = null;
        this.countryName = null;
        this.resetValidation();
      }
    },

    countryName: function (newValue) {
      if (newValue) {
        this.countryId = Object.keys(this.getCountries).find(
          (key) => this.getCountries[parseInt(key)] == newValue
        );
      }
    },
  },

  methods: {
    ...mapActions("author", ["addAuthor"]),
    ...mapActions("country", ["bindCountries"]),
    async _addAuthor() {
      try {
        this.validate();
        const { fullName, birthYear, imageData, countryId } = this;
        console.log(imageData);
        await this.addAuthor({
          fullName,
          birthYear,
          countryId,
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

  computed: {
    ...mapGetters("country", ["getCountries"]),
    getCountryNames() {
      if (this.getCountries) {
        return Object.values(this.getCountries);
      } else return [];
    },
  },

  async created() {
    await this.bindCountries();
  },
};
</script>

<style>
.v-application--is-ltr textarea::-webkit-scrollbar {
  display: none;
}
</style>