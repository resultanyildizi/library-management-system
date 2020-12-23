<template>
  <v-stepper-content step="3" class="pa-2 pb-0">
    <v-card max-height="500">
      <v-row>
        <v-col class="px-6">
          <span class="text-h6">Select a category</span>
          <v-radio-group v-model="categoryId">
            <v-radio
              v-for="leaf in leaves"
              :key="leaf.item.id"
              :label="`${leaf.cameFrom} ${leaf.item.name}`"
              :value="leaf.item.id"
            ></v-radio>
          </v-radio-group>
        </v-col>
      </v-row>
      <v-row class="ma-0 py-0">
        <v-spacer></v-spacer>
        <v-btn class="mr-2" text @click="categoryId = null"> Reset </v-btn>
        <v-btn
          :loading="loading"
          @click="_updateCategoryId"
          depressed
          color="primary"
        >
          Next
        </v-btn>
      </v-row>
    </v-card>
  </v-stepper-content>
</template>

<script>
import { mapGetters, mapActions } from "vuex";
export default {
  name: "AddBookFormStep3",
  data() {
    return {
      loading: false,
      leaves: [],
      categoryId: null,
    };
  },

  props: {
    bookInfo: {
      type: Object,
    },
  },

  created() {
    this.calculateLeaves(this.categories, "");

    if (this.bookInfo) {
      this.categoryId = this.bookInfo.categoryId;
    }
  },

  computed: {
    ...mapGetters("category", ["getCategories"]),
    categories() {
      return this.getNodes(this.getCategories);
    },
  },

  methods: {
    ...mapActions("book", ["updateCategoryId"]),

    async _updateCategoryId() {
      try {
        this.loading = true;
        const { categoryId } = this;

        await this.updateCategoryId({
          categoryId,
        });
      } catch (err) {
        console.log(err);
      }
      this.loading = false;
      this.$emit("nextStep");
    },

    getNodes(items) {
      return items.map((item) => ({
        id: item.categoryId,
        name: item.name,
        children: item.children ? this.getNodes(item.children) : [],
      }));
    },
    calculateLeaves(items, cameFrom) {
      return items.forEach((item) => {
        if (item.children.length <= 0) {
          if (cameFrom.includes(">") && cameFrom.slice(-2) !== "> ")
            cameFrom += " >";
          this.leaves.push({ item, cameFrom });
        } else {
          cameFrom += item.name + " > ";
          this.calculateLeaves(item.children, cameFrom);
          cameFrom = cameFrom.split(" > ").slice(0, -2).join(" > ");
        }
      });
    },
    resetForm() {
      this.$refs.form.reset();
    },

    addAuthorForm() {
      this.$refs.addAuthorForm.dialog = true;
    },

    addPublisherForm() {
      this.$refs.addPublisherForm.dialog = true;
    },
  },
};
</script>

<style scoped>
</style>