<template>
  <v-stepper-content step="3" class="pa-2 pb-0">
    <v-form ref="form" v-model="valid">
      <span class="subheader">Name & Language</span>
      <v-row>
        <v-col cols="6">
          <v-text-field
            v-model="name"
            :rules="nameRules"
            color="secondary"
            label="Book's name*"
            outlined
            dense
          ></v-text-field>
        </v-col>
        <v-col cols="6">
          <v-select
            :items="getLanguageNames"
            v-model="language"
            color="secondary"
            label="Language"
            outlined
            dense
          ></v-select>
        </v-col>
      </v-row>
      <span class="subheader">Publish year & Edition & Pages</span>
      <v-row>
        <v-col cols="4">
          <v-text-field
            v-model="publishYear"
            :rules="publishYearRules"
            color="secondary"
            label="Publish Year"
            outlined
            dense
          ></v-text-field>
        </v-col>

        <v-col cols="4">
          <v-text-field
            v-model="edition"
            :rules="editionRules"
            color="secondary"
            label="Edition"
            outlined
            dense
          ></v-text-field>
        </v-col>
        <v-col cols="4">
          <v-text-field
            v-model="pagesCount"
            :rules="pagesCountRules"
            color="secondary"
            label="Pages Count"
            outlined
            dense
          ></v-text-field>
        </v-col>
      </v-row>
      <span class="subheader">Description</span>
      <v-row>
        <v-col>
          <v-textarea
            rows="3"
            :rules="descriptionRules"
            v-model="description"
            color="secondary"
            label="Description"
            no-resize
            outlined
            dense
          ></v-textarea>
        </v-col>
      </v-row>

      <span class="subheader">Dimensions & Cover image</span>
      <v-row class="pb-0 mb-0">
        <v-col cols="6" class="d-flex justify-end pb-0 mb-0">
          <v-text-field
            v-model="width"
            :rules="widthRules"
            color="secondary"
            dense
            outlined
            label="Width"
          ></v-text-field>
          <v-text-field
            v-model="height"
            :rules="heightRules"
            color="secondary"
            dense
            outlined
            label="Height"
          ></v-text-field>
        </v-col>
        <v-col cols="6" class="pb-0 mb-0">
          <v-file-input
            v-model="imageData"
            :rules="imageRules"
            outlined
            accept="image/png, image/jpeg, image/bmp"
            prepend-icon="mdi-image"
            label="Select an image"
            dense
            color="secondary"
          ></v-file-input>
        </v-col>
      </v-row>
    </v-form>
    <v-row class="ma-0 py-0">
      <v-spacer></v-spacer>
      <v-btn
        :loading="loading"
        :disabled="!valid"
        @click="_addBook()"
        depressed
        color="primary"
        >Next</v-btn
      >
    </v-row>
  </v-stepper-content>
</template>

<script>
import { mapActions } from "vuex";
import { mapGetters } from "vuex";
export default {
  name: "AddBookFormStep1",

  watch: {},
  data() {
    return {
      name: null,
      publishYear: null,
      edition: null,
      pagesCount: null,
      height: null,
      width: null,
      imageData: null,
      language: null,
      description: null,
      valid: false,
      loading: false,

      nameRules: [
        (v) => (!!v && v.length > 1) || "Name is required",
        (v) =>
          (!!v && v.length < 200) ||
          "Name can't have longer than 200 characters",
      ],
      publishYearRules: [
        (v) =>
          !v ||
          (v > 0 && v < 9999 && /^\d*$/.test(v)) ||
          "Invalid publish year",
      ],
      pagesCountRules: [
        (v) => !v || (v > 5 && /^\d*$/.test(v)) || "Invalid pages count",
      ],
      editionRules: [
        (v) => !v || (v > 0 && /^\d*$/.test(v)) || "Invalid edition ",
      ],
      widthRules: [
        (v) => !v || v > 5 || /^[0-9]+(\.[0-9]+)+$/.test(v) || "Invalid width",
      ],
      heightRules: [
        (v) => !v || v > 5 || /^[0-9]+(\.[0-9]+)+$/.test(v) || "Invalid height",
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
  computed: {
    ...mapGetters("language", ["getLanguageNames"]),
    ...mapGetters("language", ["getLanguageMap"]),
    ...mapGetters("book", ["getLastInsertedBookId"]),
  },

  methods: {
    ...mapActions("book", ["addBook"]),
    async _addBook() {
      this.loading = true;
      console.log(this.valid);
      if (this.valid) {
        const {
          name,
          publishYear,
          edition,
          pagesCount,
          height,
          width,
          imageData,
          language,
          description,
        } = this;

        await this.addBook({
          name,
          publishYear,
          edition,
          pagesCount,
          height,
          width,
          imageData,
          languageId: this.getLanguageMap[language],
          description,
        });

        this.$emit("nextStep");
        this.loading = false;
        console.log(this.getLastInsertedBookId);
      }
    },

    resetForm() {
      this.$refs.form.reset();
    },

    validate() {
      this.$refs.form.validate();
    },
  },
};
</script>

<style scoped>
</style>