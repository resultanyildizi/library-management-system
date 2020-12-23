<template >
  <v-dialog v-model="dialog" max-width="700" persistent>
    <v-card style="cursor: initial">
      <v-toolbar elevation="1" color="secondary" dark>
        <v-toolbar-title class="google-sans-regular">
          Add new book
        </v-toolbar-title>
        <v-spacer></v-spacer>
        <v-btn icon dark @click="dialog = false">
          <v-icon>mdi-close</v-icon>
        </v-btn>
      </v-toolbar>
      <v-card-text class="px-6 pt-3">
        <v-stepper v-model="e1" class="elevation-0" v-if="dialog">
          <v-stepper-header class="elevation-0">
            <v-stepper-step :complete="e1 > 1" step="1"> Book </v-stepper-step>
            <v-divider></v-divider>
            <v-stepper-step :complete="e1 > 2" step="2">
              Credits
            </v-stepper-step>
            <v-divider></v-divider>
            <v-stepper-step step="4"> Category </v-stepper-step>
          </v-stepper-header>

          <v-stepper-items>
            <add-book-form-step-1
              ref="step1Content"
              v-on:nextStep="e1 = 2"
              :bookInfo="bookInfo"
            />
            <add-book-form-step-2
              ref="step2Content"
              v-on:nextStep="e1 = 3"
              :bookInfo="bookInfo"
            />
            <add-book-form-step-3
              ref="step3Content"
              v-on:nextStep="dialog = false"
              :bookInfo="bookInfo"
            />
          </v-stepper-items>
        </v-stepper>
      </v-card-text>
    </v-card>
  </v-dialog>
</template>

<script>
import AddBookFormStep1 from "./AddBookFormStep1.vue";
import AddBookFormStep2 from "./AddBookFormStep2.vue";
import AddBookFormStep3 from "./AddBookFormStep3.vue";
export default {
  components: { AddBookFormStep1, AddBookFormStep2, AddBookFormStep3 },
  name: "AddBookForm",
  data() {
    return {
      bookInfo: null,
      e1: 1,
      dialog: false,
      notifications: false,
      sound: true,
      widgets: false,
    };
  },

  created() {},

  watch: {
    dialog(val) {
      if (!val) {
        this.e1 = 1;
        this.bookInfo = null;
        this.$refs.step1Content.resetForm();
      }
    },
  },
};
</script>

<style >
</style>

