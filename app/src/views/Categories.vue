<template>
  <section style="height: 100%" class="px-8">
    <!-- <add-author-form ref="addAuthorForm" /> -->
    <add-category-dialog ref="addCategoryForm" />
    <circular-progress v-if="!getCategories" />
    <v-container v-else>
      <floating-action-button
        :icon="'mdi-plus'"
        :text="'Add new category'"
        :action="fabAction"
      />
      <h1 class="google-sans-regular pl-6 mb-0 text-center">
        📚 Categories 📚
      </h1>
      <v-divider class="my-4 mb-6"></v-divider>
      <category-tree-view v-on:openCategoryFormDialog="openFormDialog" />
    </v-container>
  </section>
</template>

<script>
import CircularProgress from "@/components/Core/CircularProgress";
import FloatingActionButton from "../components/Core/FloatingActionButton.vue";
import { mapActions, mapGetters } from "vuex";
import CategoryTreeView from "../components/Category/CategoryTreeView.vue";
import AddCategoryDialog from "../components/Category/AddCategoryDialog.vue";
export default {
  name: "Categories",

  components: {
    CircularProgress,
    FloatingActionButton,
    CategoryTreeView,
    AddCategoryDialog,
  },
  methods: {
    ...mapActions("category", ["bindCategories"]),

    openFormDialog(item) {
      this.$refs.addCategoryForm.dialog = true;
      this.$refs.addCategoryForm.parentId = item.id;
      this.$refs.addCategoryForm.parentName = item.name;
    },
    fabAction() {
      this.openFormDialog({ id: null, name: null });
    },
  },

  computed: {
    ...mapGetters("category", ["getCategories"]),
  },
  created() {
    this.bindCategories();
  },
};
</script>

<style>
</style>